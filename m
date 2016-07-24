From: Rami Rosen <roszenrami@gmail.com>
Subject: Re: Is there a way to force probe to be called (etherned driver) ?
Date: Sun, 24 Jul 2016 17:44:57 +0300
Message-ID: <CAKoUAr=A1d5u_9w+29Bf1v8Du=UyPSh8v89cyx49hdK3LM3O7w@mail.gmail.com>
References: <CAJ2oMh+mjySAQbOEmkQGvfO+JmC-mdQ3HBEFRViA-vpEGeTJQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <CAJ2oMh+mjySAQbOEmkQGvfO+JmC-mdQ3HBEFRViA-vpEGeTJQA@mail.gmail.com>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-omap@vger.kernel.org

Hi, Ran,

Do you define the probe as a member is a platform_driver object ?
See for example,
http://lxr.free-electrons.com/source/drivers/net/ethernet/marvell/mvneta.c#L4219

In this case, maybe something is missing/wrong in
platform_device_register();

or do you use a platfom_driver object ?
http://lxr.free-electrons.com/source/include/linux/platform_device.h#L180

In this case, maybe something is missing/wrong in platform_driver_register().

Regards,
Rami Rosen
http://ramirose.wix.com/ramirosen





In case you do, probably something is missing in your
platform_device_register() method (which may be in arch/arm/plat-...)

On 24 July 2016 at 11:51, Ran Shalit <ranshalit@gmail.com> wrote:
> Hello,
>
>
> I write ethernet driver (mac controller is implemented in fpga connected to cpu)
>
> I see that the probe is not called on doing insmod.
>
> Is there a way to force the probe to be called on doing insmod ?
>
> I could not find in the board file (omap dart, kernel 3.4.0) any
> reference to ethernet.
>
>
> Best Regards,
>
> Ran
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
