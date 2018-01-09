From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Tue, 9 Jan 2018 12:55:11 +0100
Message-ID: <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, linux-omap <linux-omap@vger.kernel.org>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Johan,

> Am 22.12.2017 um 15:40 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> Hi Johan,
> 
>> Am 22.12.2017 um 13:44 schrieb Johan Hovold <johan@kernel.org>:
>> 
>> On Fri, Dec 01, 2017 at 08:49:36AM +0100, H. Nikolaus Schaller wrote:
>>> Add driver for Wi2Wi W2SG0004/84 GPS module connected to some SoC UART.
>>> 
>>> It uses serdev API hooks to monitor and forward the UART traffic to /dev/ttyGPSn
>>> and turn on/off the module. It also detects if the module is turned on (sends data)
>>> but should be off, e.g. if it was already turned on during boot or power-on-reset.
>>> 
>>> Additionally, rfkill block/unblock can be used to control an external LNA
>>> (and power down the module if not needed).
>>> 
>>> The driver concept is based on code developed by Neil Brown <neilb@suse.de>
>>> but simplified and adapted to use the new serdev API introduced in v4.11.
>> 
>> I'm sorry (and I know this discussion has been going on for a long
>> time),but this still feels like too much of a hack.

Happy new year ... Happy new attempt...

Let's restart this discussion and focus on the main roadblock (others are minor
details which can be sorted out later).

If it feels like a hack, the key issue seems to me to be the choice of
the API to present the GPS data to user space. Right?

I see three reasonable options how this presentation can be done:

1. char device
2. tty device
3. some new gps interface API (similar to network, bluetooth interfaces)
4. no driver and use the UART tty directly

Pros and cons:

1. char device
+ seems to save resources (but IMHO doesn't if we look deeper to handle select, blocking, buffer overflow)
- the standard function of buffering a character stream has to be done by this driver again, although tty subsystem already has proper buffering
- no line disciplines (e.g. if some gps client wants to translate CR and NL or use canonical/noncanonical mode)
- capabilities of the interface change if same chip is connected through USB or Bluetooth serial interface

2. tty device
+ full tty port like USB, Bluetooth or UART connection (w/o driver)
+ handles tcsetattr like USB, Bluetooth or UART
+ buffering and line disciplines come for free (at least wrt. driver code)
+ tested
- seems to appear to be complex and overkill and a hack (but IMHO is neither)

3. some new gps interface API
+ could become very elegant and general
- does not exist (AFAIK not even a plan but I am not aware of everything)
- no user-space daemons and applications exist which use it

4. no driver and use UART directly
+ a non-solution seems to be attractive
- must turn on/off chip by gpio hacks from user-space
- can not guarantee (!) to power off the chip if the last user-space process using it is killed
  (which is essential for power-management of a handheld, battery operated device)

I would clearly prefer 3 over 2 over 1 over 4.

So do you see a chance that the kernel core team provides something useable
(not perfect) for variant 3 in reasonable time (let's say 3-6 months)?

If not, I want to suggest to accept the second-best choice 2. for now and we
will update the driver as soon as 3. appears. IMHO it would be a good test case
for a new subsystem.

Please advise how you want to proceed.

BR and thanks,
Nikolaus
