From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: dspgateway sem2mutex conversion.
Date: Thu, 4 May 2006 07:01:27 -0700
Message-ID: <20060504140127.GN8664@atomide.com>
References: <20060503194842.GA31013@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060503194842.GA31013@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <paul.mundt@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Mundt <paul.mundt@nokia.com> [060503 12:49]:
> This has been lagging behind a bit, primarily due to the fact that the
> OMAP tree has gotten a bit out of sync with the DSP gateway updates
> (we'll leave that for another patch).
> 
> This is a quick and simple sem2mutex conversion, after this dspgateway is
> essentially down to a single rwsem for the exmap cases, and that will
> remain as it is.
> 
> Against current git.

Thanks & pushed.

Tony
