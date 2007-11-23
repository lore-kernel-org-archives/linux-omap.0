From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: Re: Nokia N810 support
Date: Fri, 23 Nov 2007 03:45:46 +0200
Message-ID: <20071123014546.GA12883@pure.research.nokia.com>
References: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>
	<1195808944.32096.11.camel@mort>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1195808944.32096.11.camel@mort>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 23/11/07 11:09 +0200, Igor Stoppa wrote:
> Hi,
> On Fri, 2007-11-23 at 02:38 +0200, ext Lauri Leukkunen wrote:
> > This patch-set provides basic support for N810. Comments are welcome,
> > especially concerning structuring of the board-nXX.c files in the
> > future.
> 
> Would it make sense to have just one common set of files for platforms
> that are almost identical and can run the same binaries?
> 
> The Nokia product naming scheme might not help us, but what about
> board-nokia-2420.c ?

I decided against renaming the board-n800*.c files to keep the patch
small. Also I think it is more obvious to use a real product name, instead of
a reference to the particular chip they're using. Let's see how this works
out. Right now the n800 files are effectively the common set, n810 will be
the product specific one. As we work on publishing the different drivers
maybe we'll evolve this towards board-nokia-2420.

/lauri
