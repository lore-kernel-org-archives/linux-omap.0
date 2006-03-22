From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] Add support for Amstrad Delta (E3) Videophone
Date: Wed, 22 Mar 2006 19:59:47 +0000
Message-ID: <20060322195947.GN26949@earth.li>
References: <20060322113903.GK5187@earth.li> <44219E18.1030007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <44219E18.1030007@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 22, 2006 at 07:57:28PM +0100, Dirk Behme wrote:
> Jonathan McDowell wrote:
> >--- /dev/null
> >+++ b/arch/arm/configs/ams_delta_defconfig
> 
> How about name it omap_ams_delta_defconfig?
> 
> Should we rename palmte_defconfig and n770_defconfig to 
> omap_* as well?

The MACH definition is MACH_AMS_DELTA, which is why I named the
defconfig that. I note that the n770 is MACH_NOKIA770 however and palmte
is MACH_OMAP_PALMTE.

J.

-- 
] http://www.earth.li/~noodles/ []  Been through Hell?? and what did   [
]  PGP/GPG Key @ the.earth.li   []           you bring me??            [
] via keyserver, web or email.  []                                     [
] RSA: 4DC4E7FD / DSA: 5B430367 []                                     [
