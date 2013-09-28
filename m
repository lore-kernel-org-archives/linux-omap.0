From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v12 0/7] PHY framework
Date: Sat, 28 Sep 2013 15:12:12 +0530
Message-ID: <5246A474.90500@ti.com>
References: <1380263012-9687-1-git-send-email-kishon@ti.com>
 <20130928003742.GA3659@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130928003742.GA3659@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mark.rutland@arm.com, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, s.nawrocki@samsung.com, linux@arm.linux.org.uk, sameo@linux.intel.com, ijc+devicetree@hellion.org.uk, davidb@codeaurora.org, cesarb@cesarb.net, devicetree@vger.kernel.org, george.cherian@ti.com, rob@landley.net, pawel.moll@arm.com, swarren@wwwdotorg.org, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com, balajitk@ti.com, jkosina@suse.cz, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, t-kristo@ti.com, bcousson@baylibre.com, joe@perches.com, akpm@linux-foundation.org, davem@davemloft.net, m.chehab@samsung.com
List-Id: linux-omap@vger.kernel.org

On Saturday 28 September 2013 06:07 AM, Greg KH wrote:
> On Fri, Sep 27, 2013 at 11:53:24AM +0530, Kishon Vijay Abraham I wrote:
>> Added a generic PHY framework that provides a set of APIs for the PHY drivers
>> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
>> the PHY with or without using phandle.
>>
>> This framework will be of use only to devices that uses external PHY (PHY
>> functionality is not embedded within the controller).
>>
>> The intention of creating this framework is to bring the phy drivers spread
>> all over the Linux kernel to drivers/phy to increase code re-use and to
>> increase code maintainability.
>>
>> Comments to make PHY as bus wasn't done because PHY devices can be part of
>> other bus and making a same device attached to multiple bus leads to bad
>> design.
>>
>> If the PHY driver has to send notification on connect/disconnect, the PHY
>> driver should make use of the extcon framework. Using this susbsystem
>> to use extcon framwork will have to be analysed.
>>
>> You can find this patch series @
>> git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git testing
>>
>> I'll create a new branch *next* once this patch series is finalized. All the
>> PHY driver development that depends on PHY framework can be based on this
>> branch.
>>
>> Did USB enumeration testing in panda and beagle after applying [1] (needed for
>> non-dt)
> 
> All now applied to my usb-next branch.  Thanks for redoing this many
> times and sticking with it.

Thanks :-)

-Kishon
