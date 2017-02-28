From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP2+: Grab reference to device nodes where needed
Date: Tue, 28 Feb 2017 08:23:16 -0800
Message-ID: <20170228162315.GS21809@atomide.com>
References: <1486853948-20978-1-git-send-email-linux@roeck-us.net>
 <20170227233405.GA16546@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170227233405.GA16546@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Qi Hou <qi.hou@windriver.com>, linux-omap@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [170227 15:36]:
> ping ... this problem is now seen in mainline.

Oops sorry I had accidentally tagged this with "next" instead of
"fixes".

Looking at the patch though, can't we make of_node_get/put local to
omap3xxx_hwmod_is_hs_ip_block_usable()?

Regards,

Tony
