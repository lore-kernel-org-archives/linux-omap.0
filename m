From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCHv3 2/3] EDAC: ti: add support for TI keystone and DRA7xx
 EDAC
Date: Mon, 13 Nov 2017 10:04:09 -0800
Message-ID: <f9d1b261-7942-6ff6-bfc3-4b3ff22f0e27@oracle.com>
References: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <1510578490-14510-1-git-send-email-t-kristo@ti.com>
 <47e1810b-a10b-28fb-ba0e-fe28ae337c61@oracle.com>
 <20171113175816.qmvbug4kf3qu5meq@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171113175816.qmvbug4kf3qu5meq@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mchehab@kernel.org, tony@atomide.com, Tero Kristo <t-kristo@ti.com>, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/13/2017 9:58 AM, Borislav Petkov wrote:
> On Mon, Nov 13, 2017 at 09:10:09AM -0800, Santosh Shilimkar wrote:
>> Once you have driver queued up, please post DTS patches
>> separately. Will queue them up.
> 
> It would be easier if you ACK the DTS patches and I can pick all three
> up after the merge window is over. This way they go together and there's
> no inter-tree dependency.
> 
That doesn't help and not an usual workflow.
DTS patches actually conflict and they better go through arch port.
Let the driver get merged which has no dependency with DTS patches
instead of waiting for merge window being over. DTS patches can be
merged anytime once its respective driver are in tree.

Regards,
Santosh
