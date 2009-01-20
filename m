From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: mmci-omap regressions
Date: Tue, 20 Jan 2009 01:10:04 +0000
Message-ID: <yw1xfxjeu6j7.fsf@thrashbarg.mansr.com>
References: <20090112091721.GA11921@michl.2n.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46269 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547AbZATBKW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jan 2009 20:10:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LP58C-00037k-7s
	for linux-omap@vger.kernel.org; Tue, 20 Jan 2009 01:10:16 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2009 01:10:16 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2009 01:10:16 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Ladislav Michl <ladis@linux-mips.org> writes:

> Last time I used MMC card with linux-2.6.15-omap2 and it worked
> pretty well on my custom 5910 based board. Current git nor
> linux-2.6.22-omap1 (currently used for production) doesn't work at
> all. Inspecting diff between 2.6.15-omap2 and 2.6.22-omap1 showed
> that

[...]

> Doing the same modification in current git doesn't help. Moreover rem=
oving
> omap.ko and inserting again behaves differently than inserting for fi=
rst
> time:
> # modprobe omap
> mmci-omap mmci-omap.0: command timeout (CMD8)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmc0: error -22 whilst initialising MMC card
> # rmmod omap
> # modprobe omap
> mmci-omap: probe of mmci-omap.0 failed with error -16
>
> I'll happily send any requested debug informations and test any patch=
es

I'm getting the same error on Nokia 770.  Anything I can do to help?

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
