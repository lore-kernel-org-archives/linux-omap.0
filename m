From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: Pending July patches
Date: Thu, 10 Aug 2006 10:07:20 +0200
Message-ID: <fb249edb0608100107rf15805dpb756b2cc0aacae31@mail.gmail.com>
References: <20060803111721.GH8661@atomide.com>
	<20060803120858.53676.qmail@web37909.mail.mud.yahoo.com>
	<20060804110530.GC26416@atomide.com> <44D35C5C.8060602@cc.jyu.fi>
	<20060807152344.GH10387@atomide.com> <44D7D332.3050101@cc.jyu.fi>
	<fb249edb0608071830x5035afd3y4b993a16d578f688@mail.gmail.com>
	<fb249edb0608092141g71e176e6qe6cabfc245970f36@mail.gmail.com>
	<20060810073250.GC30195@atomide.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060810073250.GC30195@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 10/08/06, Tony Lindgren <tony@atomide.com> wrote:
> * andrzej zaborowski <balrog@zabor.org> [060810 07:41]:
> > >
> > >Personally I didn't have problems with MMC/SD support on OMAP1 with
> > >current git, except the 2GB and 4GB cards (but we have a workaround
> > >for those). Instead I see strange things happen with the LCD -- It
> > >takes about 1 second to initialise (in 2.6.16 you couldn't notice
> >
> > Oops, actually it was in the MMC/SD driver. Because the lines
> >        if (!irqs_disabled())
> >                return -EAGAIN;
> > in mmc_omap_suspend were removed, LCD & backlight are now suspended
> > before MMC and resumed first which results in a weird visual effect
> > while cards are detected but no slowdown as far as I can tell.
>
> Do you have a patch for that?

Well, it's just aesthetics. If you put these two lines back in
mmc_omap_suspend(), resuming will look better because LCD & backlight
resumes last, but there's a trade-off, according to
Documentation/power/devices.txt (which I only found out about today):
when a driver returns -EAGAIN, it will be suspended as last but it can
only be suspended with the whole system. Run-time suspending won't
work (i.e. "echo 1 > /sys/devices/platform/mmci-omap.1/power/state"
will fail) so it's probably not desirable.
I don't know how to force LCD to be resumed last.

>
> Tony
>

Regards,
Andrzej
-- 
balrog 2oo6

Dear Outlook users: Please remove me from your address books
http://www.newsforge.com/article.pl?sid=03/08/21/143258
