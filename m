From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 2/3] EDAC: ti: add support for TI keystone and DRA7xx
 EDAC
Date: Mon, 13 Nov 2017 20:49:03 +0200
Message-ID: <cdaf8a76-c249-cd79-f03b-bfd78a5f7fbf@ti.com>
References: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <1510578490-14510-1-git-send-email-t-kristo@ti.com>
 <47e1810b-a10b-28fb-ba0e-fe28ae337c61@oracle.com>
 <20171113175816.qmvbug4kf3qu5meq@pd.tnic>
 <f9d1b261-7942-6ff6-bfc3-4b3ff22f0e27@oracle.com>
 <20171113180843.hif7mfx5crvndito@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171113180843.hif7mfx5crvndito@pd.tnic>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: mchehab@kernel.org, tony@atomide.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/11/17 20:08, Borislav Petkov wrote:
> On Mon, Nov 13, 2017 at 10:04:09AM -0800, Santosh Shilimkar wrote:
>> DTS patches can be merged anytime once its respective driver are in
>> tree.
> 
> Works for me too.
> 

I guess you can just merge the dts patch also whenever you like, as 
there is currently no support around for ti,emif-keystone. It just won't 
do anything.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
