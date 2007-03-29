From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Basic support for OMAP24xx EAC
Date: Thu, 29 Mar 2007 16:08:11 -0400
Message-ID: <20070329200809.GF3638@atomide.com>
References: <20070302125947.84276a06.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070302125947.84276a06.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Jarkko Nikula <jarkko.nikula@nokia.com> [070302 07:06]:
> Hi
> 
> I'm sending here patches to have basic support for OMAP24xx Enhanced Audio Controller. This is pretty much useless without DSP and does contain support only for I2S link.
> 
> Basically this is mostly same what was in released N800 source code. Only functional difference is small fix in eac_enable_clocks function and some long line clean-ups.
> 
> Major difference is that I removed ugly register description comments and then put them back as a separate patch. These are originated, IIRC, from some reference implementation header file. That second patch we don't want to push :-)
> 
> 1/2: Actual EAC patch for review/push
> 2/2: DON'T push, just for reference

Pushing these today. I split the board init into a separate patch.

Tony
