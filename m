From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 07/43] CLK: TI: add autoidle support
Date: Mon, 4 Nov 2013 08:59:07 -0600
Message-ID: <5277B63B.7080106@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
 <1382716658-6964-8-git-send-email-t-kristo@ti.com> <52727FDA.7060009@ti.com>
 <527371F5.9080702@ti.com> <5273FDF1.6090405@ti.com> <52777042.40703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52777042.40703@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/04/2013 04:00 AM, Tero Kristo wrote:
> On 11/01/2013 09:16 PM, Nishanth Menon wrote:
>> On 11/01/2013 04:18 AM, Tero Kristo wrote:

[...]
>> one other thing I missed, will be nice to introduce a common bindings
>> for autoidle which tends to be reused in other drivers..
> 
> You mean documentation or? Autoidle from this patch is only used by two 
> clock drivers (divider + fixed-factor.) DPLLs use completely different 
> setup. Converting the interface clocks to use the same might be rather 
> nasty thing to do.
The definitions are common - so, yes, it will be nice to have
autoidle.txt which is then pointed to by divider, fixed-clock etc..


-- 
Regards,
Nishanth Menon
