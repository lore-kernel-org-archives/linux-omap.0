From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH] arm: omap2+: hwmod: Add qspi data for am437x.
Date: Tue, 15 Oct 2013 10:43:36 +0530
Message-ID: <525CCF00.4010404@ti.com>
References: <1381773742-3931-1-git-send-email-sourav.poddar@ti.com>
 <alpine.DEB.2.02.1310141933130.22465@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1310141933130.22465@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: afzal@ti.com, linux@arm.linux.org.uk, tony@atomide.com, nsekhar@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 15 October 2013 01:04 AM, Paul Walmsley wrote:
> Hi
>
> On Mon, 14 Oct 2013, Sourav Poddar wrote:
>
>> Add hwmod data for qspi for AM437x.
>>
>> Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
>> ---
>> This was tested on AM437x EPOS EVM with Afzal's v6 of AM43x PRCM
>> basic support and tero's DT clock series.
> Could you please rebase this on top of George Cherian's patch:
>
> "[PATCH] ARM: OMAP2+: hwmod: Add USB hwmod data for AM437x."
>
> ?
>
>
Yes, I will do and send you the updated patch.
> - Paul
