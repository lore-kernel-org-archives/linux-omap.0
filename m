From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH 0/5] Clean up omap24xx.h symbolic constants
Date: Thu, 17 May 2007 12:28:47 +0400
Message-ID: <464C123F.6050005@gmail.com>
References: <20070516225850.075133914@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070516225850.075133914@pwsan.com>
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

Hello,

Paul Walmsley wrote:
> So, to continue the example above, the OMAP24XX_SDRC_BASE constant
> will be removed, and replaced with two defines: OMAP2420_SDRC_BASE and
> OMAP243X_SDRC_BASE.  Depending on which CONFIG_ARCH_OMAP* Kconfig
> parameter is specified, we then set an SDRC_BASE define to point to
> one of the two architecture-specific values.
>
>   
IMHO, using of SDRC_BASE as well as CTRL_BASE, PRCM_BASE etc.,
can lead to name collision, the names is not so unique as may
seem. I suggest using of OMAP_ prefix for these names.


Regards,
Dmitry
