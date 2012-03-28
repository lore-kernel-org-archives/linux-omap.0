From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
Date: Wed, 28 Mar 2012 05:04:51 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317BFECE@DBDE01.ent.ti.com>
References: <1332484600-21947-1-git-send-email-afzal@ti.com>
 <4F6D0569.6080203@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317BB895@DBDE01.ent.ti.com>
 <4F70AA82.3000204@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317BD6E2@DBDE01.ent.ti.com>
 <4F71DD6C.5010305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F71DD6C.5010305@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiremath,
 Vaibhav" <hvaibhav@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On Tue, Mar 27, 2012 at 21:01:56, Hunter, Jon wrote:
> > These are for the peripheral resources not in control of GPMC, like
> > gpio irq. These are copied in gpmc_create_child.
> 
> Right, I see they are copied during gpmc_create_child. However, I don't 
> see where they are initialised before that. The function 
> gpmc_setup_child is only initialising gpmc_res and gpmc_num_res and not 
> res and num_res. So I still don't see who is initialising these before 
> they are copied.

These are to be initialized by platform code, NAND have none so is
not currently seen, but devices like ethernet have to.

 
> I see you did not incorporate any clean-up in v2. Do you want me to send 
> you some patches to include?

Thanks for offering to help.

Cleanup is being deferred to be done once driver is finalized, I may
need your help later.

Regards
Afzal
