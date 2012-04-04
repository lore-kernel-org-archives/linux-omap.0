From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Fix wrong SYSC_TYPE1_XXX_MASK bit
 definitions
Date: Wed, 4 Apr 2012 09:53:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040953120.8000@utopia.booyaka.com>
References: <1329477961-1307-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1329477961-1307-1-git-send-email-hvaibhav@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: khilman@ti.com, b-cousson@ti.com, tony@atomide.com, thara@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 17 Feb 2012, Vaibhav Hiremath wrote:

> In the SYSC_TYPE1_XXX_MASK configuration, SYSC_XXX_SHIFT macro
> is used which is not defined anywhere in the kernel.
> Until now the build was going through successfully, since it
> is not being used anywhere in kernel.
> 
> This bug got introduced by the commit
> 358f0e630d5409ab3837b86db3595560eae773b6 ("OMAP3: hwmod: support
> to specify the offset position of various SYSCONFIG register bits.")
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks, queued for 3.4-rc.

- Paul
