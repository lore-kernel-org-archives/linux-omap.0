From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 158/493] video: remove use of __devinit
Date: Tue, 20 Nov 2012 08:57:26 -0800
Message-ID: <20121120165726.GB21706@codeaurora.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-158-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1353349642-3677-158-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-fbdev@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, Michal Januszewski <spock@gentoo.org>, Paul Mackerras <paulus@samba.org>, linux-nvidia@lists.surfsouth.com, Daniel Walker <dwalker@fifo99.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Wan ZongShun <mcuos.com@gmail.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jingoo Han <jg1.han@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jaya Kumar <jayalk@intworks.biz>, cbe-oss-dev@lists.ozlabs.org, Antonino Daplas <adaplas@gmail.com>, linux-arm-msm@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>, linux-geode@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Maik Broemme <mbroemme@plusser>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 19, 2012 at 01:21:47PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> ---
>  drivers/video/msm/mddi.c                           |  6 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
