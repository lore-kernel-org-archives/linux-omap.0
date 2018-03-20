From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Tue, 20 Mar 2018 15:49:33 +0100
Message-ID: <FCD404C1-3DD4-45BD-9242-3F7A7C44F6C9@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost> <20180212152618.GC13962@amd>
 <20180227070415.GB18666@localhost>
 <22A8F5FE-C8B9-46EB-B98D-A94EA4170131@goldelico.com>
 <20180319135418.GL18359@localhost>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180319135418.GL18359@localhost>
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Johan,

> Am 19.03.2018 um 14:54 schrieb Johan Hovold <johan@kernel.org>:
> 
> On Tue, Feb 27, 2018 at 08:32:50AM +0100, H. Nikolaus Schaller wrote:
>> Hi Johan,
>> 
>>> Am 27.02.2018 um 08:04 schrieb Johan Hovold <johan@kernel.org>:
>>> 
>>> On Mon, Feb 12, 2018 at 04:26:18PM +0100, Pavel Machek wrote:
>>>> Hi!
>>>> 
>>>>>> Let's restart this discussion and focus on the main roadblock (others
>>>>>> are minor details which can be sorted out later).
>>>>>> 
>>>>>> If it feels like a hack, the key issue seems to me to be the choice of
>>>>>> the API to present the GPS data to user space. Right?
>>>>> 
>>>>> Or even more fundamentally, does this belong in the kernel at all?
>>>> 
>>>> Yes, it does.
>> 
>> Thanks, Pavel for supporting our view.
>> 
>>> 
>>> But not necessarily in its current form.
>> 
>> Is this a "yes after some code fixes"?
> 
> No, we need some kind of at least rudimentary gps framework even if we
> allow for a raw (NMEA) interface for the time being (possibly
> indefinitely).

Ok, that would be fine if we can get that!

For a minimal set of API I think something like this (following hci_dev) would suffice:

struct gps_dev {
	...
	int (*open)(struct gps_dev *gdev);
	int (*close)(struct gps_dev *gdev);
	int (*send)(struct gps_dev *gdev, char *data, int length);
};

int gps_register_dev(struct gps_dev *gdev);
void gps_unregister_dev(struct gps_dev *gdev);
int gps_recv_nmea_chars(struct gps_dev *gdev, char *data, int length);

If that would wrap all creation of some /dev/ttyGPS0 (or however it is called),
it would fit our needs for a driver and user-space for our system.

And I would be happy to get rid of creating and registering a /dev/ttyGPS0
in the w2sg0004 driver.

Then, the driver will not need to be touched if the GPS framework is improved
in some far future (e.g. to provide some additional ioctl for getting kalman-filtered
position+heading by doing sensor fusion with some iio-based accelerometer/gyro). 

So I am looking forward to some framework for review and integration testing.

BR and thanks,
Nikolaus
