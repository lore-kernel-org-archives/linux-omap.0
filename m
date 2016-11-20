From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: Re: [PATCH] mfd: twl-core: export twl_get_regmap
Date: Sun, 20 Nov 2016 14:54:25 +0200
Message-ID: <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118185548.GA23246@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161118185548.GA23246@dell.home>
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

On Fri, Nov 18, 2016 at 8:55 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Sat, 12 Nov 2016, Nicolae Rosia wrote:
>
>> We want to get rid of global twl_i2c_{write/read}.
>> As a first step, allow clients to get the regmap and write directly
>
> What's stopping you from passing it through device data?
>
Could you elaborate a bit?
The regmaps are stored in struct twl_client [0], stored in struct
twl_private [1], both structs are defined in the source file, not in
header.
I could however just fix the problem by reworking the struct, exposing
it and use mfd_add_device as real mfd drivers do.

[0] http://lxr.free-electrons.com/source/drivers/mfd/twl-core.c#L152
[1] http://lxr.free-electrons.com/source/drivers/mfd/twl-core.c#L163
