From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] OMAP3 clock patches: first set (take two)
Date: Fri, 28 Sep 2007 16:14:22 -0700
Message-ID: <20070928231421.GW10076@atomide.com>
References: <20070927061119.551228401@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070927061119.551228401@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [070926 23:16]:
> Hello,
> 
> this is take two of the initial OMAP3430 clock tree patches, with
> several bug fixes.  UART clock enable warnings are now fixed,
> and some clocks that didn't recalculate rates correctly are now
> fixed.  A few more details are in the per-patch notes.
> 
> Boot tested on N800 and 3430SDP.  Diffstat and size have been updated at
> the end of the message.  Testing welcome, as always.

Great, I've pushed this series.

Tony
