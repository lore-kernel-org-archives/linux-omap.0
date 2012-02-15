From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Tue, 14 Feb 2012 20:56:11 -0600
Message-ID: <CAB-zwWjkCqehNAKp=gFt6Zq=XR+Mscz67oGnfY2sPjgvgpvNFQ@mail.gmail.com>
References: <20120201011239.GA797@suse.de>
	<CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
	<20120201034445.GA2979@kroah.com>
	<CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
	<20120209173528.GA31726@kroah.com>
	<CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
	<20120209185923.GB10284@kroah.com>
	<CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
	<20120210180015.GF4141@mwanda>
	<CAMP44s2HUApzGH_rExqS1bOnq0nHj4Y0vEojZN4vXNPAxC1oKA@mail.gmail.com>
	<20120210203537.GG4141@mwanda>
	<CAMP44s2OEvn7RVpwJ2zkdkxrzwrbD3+PFQbzYiOG-hvnrc4UhA@mail.gmail.com>
	<CAB-zwWhSoiMNVGQ=u=6-Umte-AaP9Qih8QMJFTyk8pjXaXysLg@mail.gmail.com>
	<CAMP44s1yY8N4z_uF1b=DKdEMGXORJUhkytEpbK2AoCSTbmiJNw@mail.gmail.com>
	<CAB-zwWjtPcdwAfQGW6iB-pLWVuM1S0YJS7ioVv_voYZH2wNM9Q@mail.gmail.com>
	<CAMP44s3sNH2qRsMHxgCbemefVye=z5E8XFLnSPvUtgA94SoV=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAMP44s3sNH2qRsMHxgCbemefVye=z5E8XFLnSPvUtgA94SoV=A@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 14, 2012 at 10:23 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>> When that case is applicable, we should first modify the loader code
>> or prepare the baseimages to be common so we can get rid of specific
>> loaders and just dump them into memory.
>
> I'd say the less workarounds, the better.

If there are ever more base images compatible with the dsp, I would
say that unifying them into a common format to be dumped in memory
isn't a workaround, and in that process we can get rid of the custom
loader code.

>> WDT could be detected by prepending common symbols into the baseimages
>> or just making the new images to treat all peripherals as resources,
>> that is, the new baseimg should actually request the wdt3 as any other
>> clock.
>
> I see, but if wdt3 is requested as another clock, the Linux ARM side
> would still need to know how to threat the WDT.

Tidspbridge does know how to treat other clock request from dsp (gpt,
mcbsp), it would be a matter of adding the logic in the arm side for
any dsp image that is able to do it, however this doesn't apply to the
current (latest) base image since it assumes the wdt3 is always
controlled by tidspbridge.

Regards,

Omar
