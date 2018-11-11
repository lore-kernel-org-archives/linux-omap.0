From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [RFC 0/9] ASoC/ARM: Merge the davinci and omap
	audio directories
Date: Sun, 11 Nov 2018 18:37:40 +0200
Message-ID: <1065fb8a-a8ec-fbe3-83eb-a308072ef6d6@bitmer.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181108083754.1746-1-peter.ujfalusi@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, tony@atomide.com, nsekhar@ti.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, jsarha@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/8/18 10:37 AM, Peter Ujfalusi wrote:
> The series also includes patches to updated the arch/arm/ files (defconfigs,
> source files using audio Kconfig symbols).
> 
> I believe with v1 all of this can be merged via ASoC tree as the chances of
> conflicts are low for the touched arch/arm files. But Sekhar and Tony can
> correct me if I'm wrong.
> 
> I think I have catched all (I hope) issues regarding to Kconfig thanks to the
> various autobuild machines out there kindly testing my linux-next-wip branch.
> 
> I would appreciate any testing comments before I send the v1!
> 
I applied on top of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git commit
abd97b7c53ac ("Merge branch 'asoc-4.21' into asoc-next").

Patches 2 and 6 didn't apply and 7-8 I skipped. For my functional
testing none of those were required.

For the sound/soc/{omap => ti} conversion you may add:

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
