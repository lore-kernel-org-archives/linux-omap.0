From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v3 1/7] regulator: tps65218: Add fixed_uV fields for dcdc5
 and dcdc6
Date: Wed, 9 Jul 2014 15:06:12 +0530
Message-ID: <53BD0D0C.9090708@ti.com>
References: <1404884193-20580-1-git-send-email-j-keerthy@ti.com> <1404884193-20580-2-git-send-email-j-keerthy@ti.com> <20140709091442.GN30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140709091442.GN30458@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.com, galak@codeaurora.org, robh+dt@kernel.org, linux@arm.linux.org.uk, balbi@ti.com, tony@atomide.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 09 July 2014 02:44 PM, Mark Brown wrote:
> On Wed, Jul 09, 2014 at 11:06:27AM +0530, Keerthy wrote:
>> Add fixed_uV fields for dcdc5 and dcdc6.
> This doesn't apply against current code, can you please check and
> resend?  There were some cleanups from Felipe that just went in, it
> looks like a collision with them.
Yup. They touch the same lines. Those patches were not yet taken
before i posted. I will rebase and post.

Thanks,
Keerthy
