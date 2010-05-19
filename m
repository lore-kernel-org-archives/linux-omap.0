From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/4] OMAP: mcbsp - add smart idle
	configuration API
Date: Wed, 19 May 2010 08:33:29 -0700
Message-ID: <878w7fhpo6.fsf@deeprootsystems.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
	<87tyq4lspw.fsf@deeprootsystems.com> <1274265808.3240.101.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1274265808.3240.101.camel@odin> (Liam Girdwood's message of
	"Wed\, 19 May 2010 11\:43\:28 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Liam Girdwood <lrg@slimlogic.co.uk> writes:

> On Tue, 2010-05-18 at 16:01 -0700, Kevin Hilman wrote:
>> Liam Girdwood <lrg@slimlogic.co.uk> writes:
>> 
>> > Add a small API to configure McBSP smart idle modes
>> > to conserve power.
>> 
>> Would be useful here to explain why client drivers need to change
>> idle modes.
>> 
>
> I think Peter has covered this in one of his replies.
>
>> Also, this patch is telling me that it's time the McBSP is converted
>> over to the omap_hwmod/omap_device infrastructure where this type
>> of functionality would already be provided.
>> 
>> Not necesssarily a reason to prevent this patch for now, but this
>> will all need to be changed when converted to hwmod.
>
> Ok, I think I'll actually just convert it to hwmod rather than adding a
> soon to be deprecated API.

Excellent, that would certainly be my preference.

For reference, you can check out the pm-wip/uart and pm-wip/mmc
branches of my tree[1] for some hwmod conversions for UART and MMC
that are in progress.

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
