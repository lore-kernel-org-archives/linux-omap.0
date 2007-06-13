From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Update menelaus chip driver to new I2C core changes
Date: Tue, 12 Jun 2007 22:59:32 -0700
Message-ID: <20070613055932.GA4030@atomide.com>
References: <5d5443650705260125r2d424136g51f68f1d0d107a39@mail.gmail.com>
	<5d5443650706080400s505b38b6jc0cc61ebcb32d119@mail.gmail.com>
	<20070612135836.GJ28834@atomide.com>
	<5d5443650706122248w62777dbk3646ce9be4786ba7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650706122248w62777dbk3646ce9be4786ba7@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070612 22:48]:
> On 6/12/07, Tony Lindgren <tony@atomide.com> wrote:
>> * Trilok Soni <soni.trilok@gmail.com> [070608 04:00]:
>> > Tony,
>> >
>> > On 5/26/07, Trilok Soni <soni.trilok@gmail.com> wrote:
>> >> Tony/David,
>> >>
>> >> First two patches are same as the patch I have sent earlier as WIP.
>> >> Third patch has changes related to n800 board and it is compile-tested
>> >> only. Please see that I have removed board-n800-pm.c in the 3rd patch,
>> >> if not accepted then please suggest better way to integrate with
>> >> menelaus-i2c changes.
>> >>
>> >
>> > Please consider these patches for omap-git or do I need to rebase?
>>
>> Can you please rebase? Looks like there is one comment from Dave
>> regarding the omap_cfg_reg() that should be removed. Or else I'm just
>> having hard time keeping up :)
>
> omap_cfg_reg() is already removed from menelaus.c in the follow up
> patch posted by David here.
>
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010105.html

OK, I had some issues with my mailfilter configuration for few days
probably around that time and my email was being sent to /dev/null :)
I saw Dave's post while browsing through the archives but then forgot
about it... So reposting would be appreciated.

>> Please also post Dave's patches in your series with From: as needed.
>>
>
> I will try to rebase and post the patches.

Thanks!

Tony
