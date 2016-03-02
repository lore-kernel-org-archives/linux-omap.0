From: Jyri Sarha <jsarha@ti.com>
Subject: Re: Alternative binding proposal for tda998x audio
 (Was: Re: [PATCH RFC v5 4/8] drm/i2c: tda998x: Add support of a DT graph of
 ports)
Date: Wed, 2 Mar 2016 10:34:22 +0200
Message-ID: <56D6A58E.4020606@ti.com>
References: <cover.1455720381.git.jsarha@ti.com>
 <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
 <20160218143530.GB9654@rob-hp-laptop> <56CF04DA.8080905@ti.com>
 <20160226004311.GM5783@n2100.arm.linux.org.uk> <56D02594.4020407@ti.com>
 <20160226112159.GO5783@n2100.arm.linux.org.uk> <56D41F1A.2030100@ti.com>
 <56D5A6AA.2030907@ti.com> <20160301163553.3ef298fb2c0bb25ef662a41d@free.fr>
 <56D5BA6D.8090904@ti.com> <20160301171630.630a47dc00060645f89bb8ab@free.fr>
 <56D5DF7D.7090608@ti.com> <20160301202619.011013effd265fdee93d4d8e@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160301202619.011013effd265fdee93d4d8e@free.fr>
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

On 03/01/16 21:26, Jean-Francois Moine wrote:
> On Tue, 1 Mar 2016 20:29:17 +0200
> Jyri Sarha <jsarha@ti.com> wrote:
>
>> I understand the short comings of simple-card and it's binding. However,
>> the binding is documented and it is feasible to extract the audio
>> connections from a simple-card binding too. In fact it models the I2S
>> connections better than straight out of tehe box graph binding. Actually
>> a graph is not the best way describe an i2s-bus with multiple DAIs
>> (codec or CPU) connected to it.
>
> I still don't understand your problem. You want something like:
>

The problem is adding redundant unused details into binding without any 
plan of ever using them.

Fundamentally my problem is finding some consensus on the tda998x ASoC 
implementation. I've been reusing your binding for couple of review 
rounds and there has been some well justified critique towards it. I 
feel stupid in pushing forward something that I do not completely agree 
myself, so I decided to try something else.

> 	audio-ports = <	TDA998x_SPDIF	0x04
> 			TDA998x_I2S	0x03>;
>
> and the graph definition would be:
>
> 	port@03 {
> 		reg = <0x03>;
> 		port-type = "audio-i2s";
> 		...
> 	};
>
> 	port@04 {
> 		reg = <0x04>;
> 		port-type = "audio-spdif";
> 		...
> 	};
>
> Apart the syntax, I don't really see the difference.
>

Yes, the necessary information is contained in both bindings. I can live 
with either one of them, but I would prefer my version. Essentially I 
would just like to move forward.

Best regards,
Jyri
