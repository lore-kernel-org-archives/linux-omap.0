From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v5 3/3] mtd: devices: elm: Low power transition support
Date: Mon, 01 Jul 2013 11:02:31 +0300
Message-ID: <1372665751.22014.41.camel@sauron.fi.intel.com>
References: <1371494799-11876-1-git-send-email-pekon@ti.com>
 <1371494799-11876-4-git-send-email-pekon@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1371494799-11876-4-git-send-email-pekon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Pekon Gupta <pekon@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, khilman@linaro.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2013-06-18 at 00:16 +0530, Pekon Gupta wrote:
> From: avinash philip <avinashphilip@ti.com>
> 
> ELM is used for locating bit-flip errors in when using BCH ECC scheme.
> This patch adds suspend/resume support for leaf level ELM driver,
> And also provides ELM register context save & restore support, so that
> configurations are preserved across hardware power-off/on transitions.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Signed-off-by: Pekon Gupta <pekon@ti.com>

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
