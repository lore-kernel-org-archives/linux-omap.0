From: Matthew Percival <matthew@capgo.com>
Subject: Re: DSP gateway build problems with 2.6.13.4
Date: Thu, 15 Dec 2005 09:07:21 +1100
Message-ID: <1134598041.8818.3.camel@localhost.localdomain>
References: <004501c5fff5$c47e5050$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <004501c5fff5$c47e5050$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> I have a 2.6.13.4 kernel which I can build and which runs nicely on my OMAP
> 5912 OSK board.
> 
> I downloaded dspgateway 3.3 and it comes with a patch from 2.6.12-omap1.

	DSP Gateway has been merged with the OMAP kernel for quite some time
now, so the version of Gateway already in your 2.6.13 kernel would be
either the same as --- or possibly newer than --- the one in the 2.6.12
patch.  It would not be difficult to modify things so the paths would
match up, but in this case it is unnecessary.  Just recompile with
CONFIG_OMAP_DSP selected.

	-- Matthew
