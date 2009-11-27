From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: AIC23: Fixing infinite loop in
	resume path
Date: Fri, 27 Nov 2009 16:48:25 +0000
Message-ID: <20091127164825.GD11913@rakim.wolfsonmicro.main>
References: <1259323858-32203-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1259323858-32203-1-git-send-email-anuj.aggarwal@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 27, 2009 at 05:40:58PM +0530, Anuj Aggarwal wrote:
> This patch fixes two issues:
> a) Infinite loop in resume function
> b) Writes to non-existing registers in resume function
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>

Applied, thanks.
