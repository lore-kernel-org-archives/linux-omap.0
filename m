From: "Grosen, Mark" <mgrosen-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC 0/8] Introducing a generic AMP/IPC framework
Date: Mon, 27 Jun 2011 21:22:15 +0000
Message-ID: <FFF198FBBF957F4393BA834040FEFFA202EDA3@DFLE35.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<4E04F0B0.4030408@codeaurora.org>
	<BANLkTi=sFtwam29i4TZdi=RO7BoytTTdrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <BANLkTi=sFtwam29i4TZdi=RO7BoytTTdrw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> From: Ohad Ben-Cohen
> Sent: Saturday, June 25, 2011 6:12 PM
> 
> Hi Stephen,
> 
> On Fri, Jun 24, 2011 at 11:16 PM, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> > Instead of devising a new firmware format, we decided
> > to just stick with elf and parse the headers in the kernel because we
> > needed them for authentication anyway. Is this reason enough to move to
> > an ELF format instead?
> 
> I think that consolidation of code is enough reason to make an effort.
> I know that our firmware format was chosen for simplicity, but I'm not
> sure if we have the tools yet to build standard ELF files for the
> remote processors (IIRC it's in the works though). I'll let Mark
> comment this one.

Yes, we are converting from "standard" ELF to the simple format. I've used the
GNU binutils to work with our ELF files. There were a few motivations:

1. Concern about complexity of parsing ELF files in kernel; however, the PIL
implementation looks pretty clean to me.

2. We added a special section (resource table) that is interpreted as part
of the loading process. The tool that generates our simple format just
recognizes a named section (".resource_table"), so perhaps that could be
done with the PIL ELF loader.

3. Smaller firmware file sizes. Our ELF files are large relative to the
payload, but this might be addressed by a better ELF "strip" utility.

> > Another difference is inter-processor dependencies. For example, on
> > msm8660 the modem can't boot until the dsp has been booted. I suppose we
> > could hide this detail in the platform specific get() implementation by
> > calling rproc_get() on the dependent processor (hopefully no locking
> > issues arise). I'd rather have it built into the core though as it isn't
> > really specific to the hardware.
> 
> No problems, I'm sure we can solve this one easily.
> 
> > If we can resolve these differences I think we can easily support remote
> > processor boot on MSM via remoteproc.
> 
> That'd be very cool, I sure do hope we can work together.

Yes, I hope we can merge our efforts on PIL and remoteproc since they seem
quite close in function and design.

Mark
