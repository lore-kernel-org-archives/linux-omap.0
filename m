From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH] ARM: OMAP: Add core fsample support
Date: Fri, 28 Apr 2006 11:55:24 -0700
Message-ID: <4452651C.1000407@mvista.com>
References: <20060428182353.GA9571@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060428182353.GA9571@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Brian Swetland wrote:
> This patch adds core support for the TI F-Sample Board (OMAP 850).
> 

Hi Brian,

Seems like you should add a separate CPU: OMAP850 at the same time.  Shouldn't 
be too much more work.

Is the OMAP850 currently detected exactly like the 730 via the JTAG ID (see 
arch/arm/mach-omap1/id.c)

Sorry I couldn't comment on this sooner.

Kevin
