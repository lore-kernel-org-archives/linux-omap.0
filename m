From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH -next] ARM: OMAP2+: omap_device: fix error return code in
 omap_device_copy_resources()
Date: Fri, 13 Oct 2017 10:08:09 -0700
Message-ID: <20171013170809.GN4394@atomide.com>
References: <1507886965-156349-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1507886965-156349-1-git-send-email-weiyongjun1@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Wei Yongjun <weiyongjun1@huawei.com> [171013 02:26]:
> Fix to return error code -EINVAL from the irq_of_parse_and_map() error
> handling case instead of 0, as done elsewhere in this function.

Thanks applying into omap-for-v4.15/ti-sysc.

Regards,

Tony
