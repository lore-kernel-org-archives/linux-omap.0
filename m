From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RFC 0/9] ASoC/ARM: Merge the davinci and omap
	audio directories
Date: Mon, 26 Nov 2018 16:55:31 +0530
Message-ID: <808d350d-9e0e-d9b5-a474-1a4fd0c9b292@ti.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
 <20181108151628.GH56134@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181108151628.GH56134@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, jarkko.nikula@bitmer.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/11/18 8:46 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181108 08:36]:
>> I believe with v1 all of this can be merged via ASoC tree as the chances of
>> conflicts are low for the touched arch/arm files. But Sekhar and Tony can
>> correct me if I'm wrong.
> 
> Good to see this :) Yes merging these changes via the ASoC tree makes
> sense to me. I will take a look and ack when you post the version
> without RFC.

Looks good to me too. And fine with the series getting merged through ASoC.

But will appreciate an immutable commit over v4.20-rc1 in case I do end
up queuing something that clashes with changes here (especially worried
about the defconfig changes - those are notorious for merge conflicts,
and are pain to resolve).

I will test this once the non-RFC version is posted.

Thanks,
Sekhar
