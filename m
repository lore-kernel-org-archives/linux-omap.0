From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] Few patches to recent OMAP McBSP and
	ASoC changes
Date: Tue, 25 Aug 2009 10:21:57 +0100
Message-ID: <20090825092156.GA27234@rakim.wolfsonmicro.main>
References: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Aug 23, 2009 at 12:24:24PM +0300, Jarkko Nikula wrote:

> These are actually independent patches but probably easier to handle as with
> the set above since some of the patches are touching both ASoC and OMAP
> subsystems. First patch is the most important since it changes the user space
> API for McBSP DMA operating mode selection. It would be more difficult to
> change it later if software starts to use current numeric value based
> operating mode selection in sysfs files.

Applied all of these, thanks!
