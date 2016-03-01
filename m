From: Jyri Sarha <jsarha@ti.com>
Subject: Re: Alternative binding proposal for tda998x audio
 (Was: Re: [PATCH RFC v5 4/8] drm/i2c: tda998x: Add support of a DT graph of
 ports)
Date: Tue, 1 Mar 2016 20:29:17 +0200
Message-ID: <56D5DF7D.7090608@ti.com>
References: <cover.1455720381.git.jsarha@ti.com>
 <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
 <20160218143530.GB9654@rob-hp-laptop> <56CF04DA.8080905@ti.com>
 <20160226004311.GM5783@n2100.arm.linux.org.uk> <56D02594.4020407@ti.com>
 <20160226112159.GO5783@n2100.arm.linux.org.uk> <56D41F1A.2030100@ti.com>
 <56D5A6AA.2030907@ti.com> <20160301163553.3ef298fb2c0bb25ef662a41d@free.fr>
 <56D5BA6D.8090904@ti.com> <20160301171630.630a47dc00060645f89bb8ab@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160301171630.630a47dc00060645f89bb8ab@free.fr>
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

On 03/01/16 18:16, Jean-Francois Moine wrote:
> On Tue, 1 Mar 2016 17:51:09 +0200
> Jyri Sarha <jsarha@ti.com> wrote:
>
>> I know that it works, I have used it myself until now, but it is not
>> needed and there is no driver that parses audio port endpoints. I see no
>> point specifying something in the binding that is not used and there no
>> specific plan to ever use it.
>>
>> AFAIU my proposed binding should work equally well with simple-card,
>> with or without multi-codec support.
>
> As told many times, the simple card is a pure Linux specific entity.
> It does not describe any hardware. It should not appear in a DT, or,
> if it does, its compatible should be "linux, simple-audio-card".
> Then, how can the other OSs know the links between the audio
> devices and the audio encoders/connectors?
>

I understand the short comings of simple-card and it's binding. However, 
the binding is documented and it is feasible to extract the audio 
connections from a simple-card binding too. In fact it models the I2S 
connections better than straight out of the box graph binding. Actually 
a graph is not the best way describe an i2s-bus with multiple DAIs 
(codec or CPU) connected to it.

> On the other way, the audio graph does not impose any particular
> software design. It just describes the links between the different
> hardware components and each OS is free to implement its own layout.
>

That is true. In the most narrow sense the i2s protocol details, or even 
TDM time-slot selections should not be in the dtb. However, is not 
feasible to write a generic machine driver that would deduce the ideal 
audio configuration just based on the i2s wiring between the audio 
components simply because that is not enough information*. So to put it 
simply the simple-card is not the perfect solution for the problem, but 
even with its flaws it is better than straight out of the box graph 
binding, and it is still entirely feasible to extract all needed 
information for any audio implementation from that binding.

Still even with my proposed binding there is nothing that prevents 
adding the graph binding on top of that if it is ever needed.

Best regards,
Jyri

* With a complete set of information of all audio wiring and component 
capabilities, including the analog only components, it would probably be 
possible to deduce a generic configuration that would work in the most 
common - simple cases, but let's not go there now.
