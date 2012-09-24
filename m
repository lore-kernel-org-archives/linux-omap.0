From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
Date: Mon, 24 Sep 2012 10:39:41 +0530
Message-ID: <505FEB15.3010008@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
 <1346230576-20004-3-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1209221852590.10663@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1209221852590.10663@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, mturquette@ti.com
List-Id: linux-omap@vger.kernel.org

On Sunday 23 September 2012 12:25 AM, Paul Walmsley wrote:
> Updated this one to include several missing clock aliases and to fix a bug
> it introduced with omap_96m_alwon_fck_3630; modified patch below.

Thanks Paul, for the updates and the fix. Updated patch looks good to
me.

regards,
Rajendra
