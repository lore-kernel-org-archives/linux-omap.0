From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] ARM: omap2: Fix build when using split object directories
Date: Wed, 18 Apr 2018 10:14:07 -0700
Message-ID: <01112996-beb6-8baf-ff87-db7b3adde245@oracle.com>
References: <20180411211543.7923-1-d-gerlach@ti.com>
 <20180412082157.GB4002@localhost.localdomain>
 <CAK7LNAQiq-4daX2K4dPyzN7zr+yfkQWSJ-yy9JHgacPpYFp94w@mail.gmail.com>
 <4343a047-18b1-409d-ccda-94e72ea63e2a@ti.com>
 <20180418170903.GG5671@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180418170903.GG5671@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: Michal Marek <michal.lkml@markovi.net>, Anders Roxell <anders.roxell@linaro.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 4/18/2018 10:09 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [180413 14:08]:
>> This is the version of this patch that we want to use, will this go through you?
> 
> Sorry for the delay, I just noticed this. Somehow I thought Santosh
> would queue it, but as the regression was introduced by a commit in
> my tree I'll pick this patch into omap-for-v4.17/fixes.
> 
I wasn't sure since the patch has both driver and platform code.
Thanks for picking up Tony !!

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
