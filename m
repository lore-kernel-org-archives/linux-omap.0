From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv3 1/7] OMAP4: PMIC: Add support for twl6030
 codec
Date: Wed, 7 Oct 2009 10:37:17 +0100
Message-ID: <20091007093717.GA3169@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90C2F648@dlee04.ent.ti.com>
	<200910061146.05080.peter.ujfalusi@nokia.com>
	<20091006163546.GA11062@rakim.wolfsonmicro.main>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BB056090@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB056090@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Lopez Cruz,
	Misael" <x0052729@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 07, 2009 at 11:56:38AM +0530, Shilimkar, Santosh wrote:

[I've reflowed your mail to fit into 80 columns]

> Since there is some sort of dependency on ASOC series with TWL_6030
> core series by Balaji, its better that these gets merged in correct
> order to avoid reworks. 

There's no ordering problem with ASoC providing the TWL6030 core patches
add the TWL6030_CORE symbol as the last thing in the merge.  None of the
ASoC drivers will be built until that symbol is defined so the absence
of the core shouldn't matter.
