From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH V6 02/15] ARM: OMAP2+: AM33XX: add lateinit hook for
 calling pm late init
Date: Thu, 10 Oct 2013 10:53:32 -0500
Message-ID: <5256CD7C.5080909@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
 <1381361098-8283-1-git-send-email-nm@ti.com> <52563BD8.1060703@ti.com>
 <20131010133209.GA13105@kahuna> <5256C5D2.9030302@ti.com>
 <5256C686.6000301@ti.com>
 <CAGo_u6r-tfnWFP_FNAm5PdWctuPVvh8-XXDscCw+zKHj0FRM_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGo_u6r-tfnWFP_FNAm5PdWctuPVvh8-XXDscCw+zKHj0FRM_A@mail.gmail.com>
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
Cc: dt list <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 10/10/2013 10:45 AM, Nishanth Menon wrote:
> On Thu, Oct 10, 2013 at 10:23 AM, Joel Fernandes <joelf@ti.com> wrote:
>> I see a function of that name already exists. I guess you can leave your patch
>> as is then and not have to do this.
> 
> 
> Can I consider that as an Acked-by :) ?

Yes, sure, for this particular patch:

Acked-by: Joel Fernandes <joelf@ti.com>

thanks,

-Joel
