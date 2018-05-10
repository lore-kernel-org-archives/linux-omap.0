From: Tony Lindgren <tony@atomide.com>
Subject: Re: Spectre and Cortex-A8/A9
Date: Thu, 10 May 2018 07:47:03 -0700
Message-ID: <20180510144703.GD98604@atomide.com>
References: <CAHCN7x+ghEW__YwgbXYO4g9HNKkwkQtXiswL1jihj0wwfKuR4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7x+ghEW__YwgbXYO4g9HNKkwkQtXiswL1jihj0wwfKuR4Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [180509 18:23]:
> There is a lot of information pushed around the web about the Spectre
> bug.  I went to ARM's support site and there are some patches
> available from February that haven't made their way into the mainline.
> 
> Sorry if this has been covered before, but I am curious to know if
> there is a good place or method to determine whether or not the
> Cortex-A8 and A9 are still vulnerable and which versions or 4.4, 4.9,
> or 4.14 have any items fixed.

Well while we're waiting to figure out what all needs to be fixed,
here's what I'd do meanwhile:

1. Make sure the bootloader sets IBE bit

2. Make sure you have CONFIG_ARM_ERRATA_430973=y

3. Apply Marc Zyngier's patches from thread "[PATCH v4 0/6] 32bit ARM
   branch predictor hardening", but note that these are still being
   discussed

4. Update kernel when patches that have been validated against
   test cases get merged

Regards,

Tony
