From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: DRA7: fix unit address of second PCIe instance
Date: Fri, 10 Jun 2016 04:44:58 -0700
Message-ID: <20160610114457.GI22406@atomide.com>
References: <f79ded6b0b41c8e13f8f396d47f9522e5471d327.1465484975.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f79ded6b0b41c8e13f8f396d47f9522e5471d327.1465484975.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [160609 08:16]:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> The unit address of the second PCIe instance
> is set to be same as that of the first instance
> (copy-paste error).

Applying into omap-for-v4.8/dt thanks.

Tony
