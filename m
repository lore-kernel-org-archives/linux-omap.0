From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/4] PM / OPP: Expose _of_get_opp_desc_node as
 dev_pm_opp API
Date: Wed, 18 Jan 2017 08:44:55 +0530
Message-ID: <20170118031455.GA11478@vireshk-i7>
References: <20170117131808.29798-1-d-gerlach@ti.com>
 <20170117131808.29798-2-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170117131808.29798-2-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 17-01-17, 07:18, Dave Gerlach wrote:
> Rename _of_get_opp_desc_node to dev_pm_opp_of_get_opp_desc_node and add it
> to include/linux/pm_opp.h to allow other drivers, such as platform OPP
> and cpufreq drivers, to make use of it.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4:
> 	Export dev_pm_opp_of_get_opp_desc_node for use in modules.
> 	
>  drivers/base/power/opp/of.c | 9 +++++----
>  include/linux/pm_opp.h      | 6 ++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
