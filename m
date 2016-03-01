From: Jyri Sarha <jsarha@ti.com>
Subject: Re: Alternative binding proposal for tda998x audio
 (Was: Re: [PATCH RFC v5 4/8] drm/i2c: tda998x: Add support of a DT graph of
 ports)
Date: Tue, 1 Mar 2016 17:51:09 +0200
Message-ID: <56D5BA6D.8090904@ti.com>
References: <cover.1455720381.git.jsarha@ti.com>
 <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
 <20160218143530.GB9654@rob-hp-laptop> <56CF04DA.8080905@ti.com>
 <20160226004311.GM5783@n2100.arm.linux.org.uk> <56D02594.4020407@ti.com>
 <20160226112159.GO5783@n2100.arm.linux.org.uk> <56D41F1A.2030100@ti.com>
 <56D5A6AA.2030907@ti.com> <20160301163553.3ef298fb2c0bb25ef662a41d@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160301163553.3ef298fb2c0bb25ef662a41d@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, peter.ujfalusi@ti.com, devicetree@vger.kernel.org, airlied@linux.ie, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/01/16 17:35, Jean-Francois Moine wrote:
> On Tue, 1 Mar 2016 16:26:50 +0200
> Jyri Sarha <jsarha@ti.com> wrote:
>
>> Ok, here is just one more simple alternative for tda998x audio binding.
>> I feel that the graph ports binding for audio does not make sense
>> without a graph based ASoC machine driver implementation. The ASoC
>> simple-card is already here and it so widely used that there is no
>> getting rid of that any time soon. This proposal provides the same
>> functionality as the patch in the root of this thread, but in a simpler
>> way and is equally compatible with simple-card.
>
> Hi Jyri,
>
> The graph port binding for the tda998x works fine with the simple card
> driver when multi-codec support is added. See
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/085855.html
>

I know that it works, I have used it myself until now, but it is not 
needed and there is no driver that parses audio port endpoints. I see no 
point specifying something in the binding that is not used and there no 
specific plan to ever use it.

AFAIU my proposed binding should work equally well with simple-card, 
with or without multi-codec support.

Best regards,
Jyri
