From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Date: Wed, 14 Nov 2018 12:19:20 +0200
Message-ID: <262d8ef0-ead2-1ec8-d2e1-0c5f6497b1fb@ti.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <1c2c1031-a6b4-cbce-ceed-c2ce229c204e@ti.com>
 <20181114003345.GV2089@sirena.org.uk>
 <CAHp75Vf7qozL8abZSh1gv_F3iSiZCprEK5_eGW=SRyUpjYrmtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf7qozL8abZSh1gv_F3iSiZCprEK5_eGW=SRyUpjYrmtA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, grant.likely@arm.com, Andrze
List-Id: linux-omap@vger.kernel.org

Andy,

On 2018-11-14 10:45, Andy Shevchenko wrote:
> On Wed, Nov 14, 2018 at 2:34 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Mon, Nov 12, 2018 at 06:11:26PM +0200, Peter Ujfalusi wrote:
>>
>>> if we revert the commit then the original issue will re-surfaces. afaik
>>> it was not only audio which hit the 'last driver to be probed from the
>>> deferred list would never probe, unless we provoke the kernel to load
>>> additional module, or remove/reload the module' issue.
>>
>> Right, aren't we just going to be swapping one bug for another?
> 
> Have anyone in possession of Davinchi tested most recent kernel with
> this revert?

I don't think it is related to daVinci, in fact we have seen the very
same issue with OMAP4.
Fwiw this was my initial patch
http://lkml.iu.edu/hypermail/linux/kernel/1404.0/01603.html
Grant based his change on this.

Note the part in the commit message:
"The issue has been observed on embedded systems with CONFIG_PREEMPT
enabled, audio support built as modules and using nfsroot for root
filesystem."

as I recall I was only able to reproduce the stall with nfsroot and
buildroot fs. The timings were different compared to MMC rootfs.

Anyways the patch fixes a real race condition which is generic:
We have driverA and driverB as modules. driverB needs driverA to be
registered to a framework (no direct, hard dependency).

1. driverA starts to probe
2. driverB starts to probe
3. driverB can not continue as driverA is not registered itself to the
framework -> driverB will defer
4. driverA registers to the framework
5. driverA probes successfully
6. driver core will prepare the deferred probe list (note: driverB is
still in it's probe, not in the deferred list)
7. driverB returns from it's probe with -EPROBE_DEFER

and here we are, driverB is alone in the deferred list and the list is
not going to be tried as driverA and driverB were the last ones to
probe.

So, driverB is in the deferred list and stays there until other driver
probes successfully as the deferred driver list only tried when a driver
loads successfully (to see if that satisfy any of the deferred driver).

We have evidence that this has happened, it is a generic issue given
that now days we have more frameworks drivers are relying on.

>>> Do I understand correctly that in your case you have two modules
>>> (dwc3-pci and extcon-intel-mrfld) in a deferred probe loop, iow both of
>>> the drivers returns -EPROBE_DEFER and they just spin?
>>
>>> If both is deferring, how this supposed to work?
>>
>> I'm struggling to follow the original explanation too :(
> 
> Sorry, guys, I confused a nit myself. The bug is there, but
> exxplanation is not fully corrent, indeed. I'll come back with more
> details later.
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
