From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DRA752: add detection of SoC information
Date: Mon, 19 May 2014 17:34:34 -0700
Message-ID: <20140520003433.GB15793@atomide.com>
References: <1400513231-25092-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1400513231-25092-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140519 08:28]:
> Currently the files in /sys/devices/soc0/ show no information about
> DRA7. Few userspace programs do depend on this information to make SoC
> specific support. So update logic to detect the relevant information and
> provide to userspace.

Thanks applying into omap-for-v3.16/soc.

Tony
