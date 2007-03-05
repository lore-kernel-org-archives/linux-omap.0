From: Tony Lindgren <tony@atomide.com>
Subject: Re: Broken ads7846 touchscreen,
	was: [PATCH] ARM: OMAP: Fix SPI merge issues and reintroduce
	omap_uwire.c
Date: Mon, 5 Mar 2007 01:59:46 -0800
Message-ID: <20070305095626.GB17801@atomide.com>
References: <45EAB7F5.2040603@googlemail.com>
	<85tzx1gple.fsf@orfeo.duckcorp.org>
	<45EAF60C.5070207@googlemail.com>
	<85vehgdba0.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85vehgdba0.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Arnaud Patard <arnaud.patard@rtp-net.org> [070304 12:07]:
> Dirk Behme <dirk.behme@googlemail.com> writes:
> 
> > Arnaud Patard (Rtp) wrote:
> >> Dirk Behme <dirk.behme@googlemail.com> writes:
> >>
> >>
> >>>Is there any special reason why
> >>>
> >>>http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=ba6d3cf6f7900c7586cca6bbd9dca55d7c6386fb
> >>>
> >>>deleted drivers/spi/omap_uwire.c?
> >>
> >>
> >> looks like forgotten git-update-index or something like that. I didn't
> >> check closely but I bet that this conflicts explains also why the
> >> ads7846 touchscreen driver doesn't work. I had to take the versions from
> >> the old linux-omap-2.6 tree to get my touchscreen back :(

Sorry, I must have hosed it while merging. I'll make sure drivers/spi
is in sync with mainline today. If we still have some necessary fixes for
spi, they should be sent to LKML for integration.

> > Do you can make a diff between the old and new version and send a
> > patch?
> 
> Sure. I'll send it in a new mail and it will probably need review from the
> ads784x guys.

We should make use the ads784x code is also in sync with mainline.

Regards,

Tony
