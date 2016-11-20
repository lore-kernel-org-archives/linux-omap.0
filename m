From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: Re: [PATCH] mfd: twl-core: make driver DT only
Date: Sun, 20 Nov 2016 14:57:24 +0200
Message-ID: <CAKP5S=1R0otWP_YFRn-jL8Q0HhPLhqy1YeF2m0CxFdbHLQGUng@mail.gmail.com>
References: <1478952153-26592-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118190115.GB23246@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161118190115.GB23246@dell.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 18, 2016 at 9:01 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Sat, 12 Nov 2016, Nicolae Rosia wrote:
>
>> All users are DT-only and it makes no sense to keep
>> unused code
>>
>> Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
>> ---
>>  drivers/mfd/Kconfig    |   1 +
>>  drivers/mfd/twl-core.c | 395 ++-----------------------------------------------
>>  2 files changed, 10 insertions(+), 386 deletions(-)
>
> I think it would be courteous to add some of the serious contributors
> to the review list.
>
> There may still be some out of tree users who might wish for a
> heads-up that this change is about to be merged.
Thanks, sure, I will do that in v2.
