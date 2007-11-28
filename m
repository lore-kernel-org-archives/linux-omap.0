From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] DSP: Move code to use only one dsp_common.h
Date: Wed, 28 Nov 2007 08:57:46 -0800
Message-ID: <20071128165745.GK11825@atomide.com>
References: <20071128051811.GI11825@atomide.com>
	<20071128.115437.259803666.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071128.115437.259803666.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [071128 01:55]:
> Hi Tony,
> 
> From: "ext Tony Lindgren" <tony@atomide.com>
> Subject: [PATCH 1/2] DSP: Move code to use only one dsp_common.h
> Date: Tue, 27 Nov 2007 21:18:12 -0800
> 
> > Hi all,
> > 
> > As discussed earlier, here are the patches to move dspgateway
> > to under drivers.
> > 
> > Hiroshi san & Toshihiro san, can you take a quick look at these
> > two patches and ack?
> > 
> > I've only compile tested on osk and n800. There should not be any
> > functional changes. Some inline functions I had to export though.
> 
> Thank you for the patch, but it doesn't seem to work. I am
> now investigating....

Oops, does the DSP get initialized?

> At least, I'd like to make sure that the code itself works fine at
> this migration both on N8x0 and OSK.

Yes that would be great :)

Tony
