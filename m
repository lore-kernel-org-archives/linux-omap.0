From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] Regression in next with codec unload and
 snd_soc_component_get/put
Date: Tue, 13 Aug 2019 09:07:59 -0500
Message-ID: <76dbd0ed-bbba-1a11-376e-7bf28c78ad9c@linux.intel.com>
References: <20190809070003.GA52127@atomide.com>
 <s5hwofmhkbs.wl-tiwai@suse.de> <20190809074643.GB52127@atomide.com>
 <s5hv9v6hhm9.wl-tiwai@suse.de> <20190813102451.GJ52127@atomide.com>
 <20190813112920.GC5093@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813112920.GC5093@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 8/13/19 6:29 AM, Mark Brown wrote:
> On Tue, Aug 13, 2019 at 03:24:51AM -0700, Tony Lindgren wrote:
>> * Takashi Iwai <tiwai@suse.de> [190809 08:24]:
> 
>>> ... and it was already fixed in the later commit 0e36f36b04e7
>>> "ASoC: soc-core: fix module_put() warning in soc_cleanup_component".
> 
>> Mark, looks like this commit is still not in Linux next, forgot
>> to push out something?
> 
> There's a build failure the Intel guys haven't fixed.

see ('ASoC: SOF: fix HDA direct MMIO access') posted on alsa-devel 
yesterday

https://mailman.alsa-project.org/pipermail/alsa-devel/2019-August/153914.html
