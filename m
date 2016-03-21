From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v8 6/6] ARM: dts: am335x-boneblack: Add
	HDMI audio support
Date: Mon, 21 Mar 2016 09:53:34 +0200
Message-ID: <56EFA87E.9020209@ti.com>
References: <cover.1458214526.git.jsarha@ti.com>
 <dd3484868647610840d4803dd3378014ce1c95b7.1458214526.git.jsarha@ti.com>
 <20160319073949.b8bcd213e92355353368fad5@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160319073949.b8bcd213e92355353368fad5@free.fr>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, airlied@linux.ie, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/19/16 08:39, Jean-Francois Moine wrote:
> On Thu, 17 Mar 2016 14:22:34 +0200
> Jyri Sarha <jsarha@ti.com> wrote:
> 
>> @@ -76,16 +87,22 @@
>>  };
>>  
>>  &i2c0 {
>> -	tda19988 {
>> +	tda19988: tda19988 {
>>  		compatible = "nxp,tda998x";
>>  		reg = <0x70>;
>> +
>>  		pinctrl-names = "default", "off";
>>  		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
>>  		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
>>  
>> -		port {
>> -			hdmi_0: endpoint@0 {
>> -				remote-endpoint = <&lcdc_0>;
>> +		#sound-dai-cells = <0>;
>> +		audio-ports = <	AFMT_I2S	0x03>;
>> +
>> +		ports {
>> +			port@0 {
>> +				hdmi_0: endpoint@0 {
>> +					remote-endpoint = <&lcdc_0>;
>> +				};
>>  			};
>>  		};
>>  	};
> 
> Why did you add a 'ports' container? As there is only one port,
> it is useless.
> 

Well, I just left it there. The node parsing code should handle the
container if it follows graph[1] binding. Putting the ports container
node is equally correct as leaving it out, but surely I can leave it out
next time (when ever it comes).

> Also, you don't need '@0' in the 'port' and 'endpoint'.
> If you want to keep it, you must add 'reg = 0;'s.
> 

I am still not sure about the "must" part. From all that I have read[2]
the unit number should be the same as reg property if possible. But then
again if the reg property consists of multiple addresses, how do you put
them in the unit address? To me no unit address at all is an analogue
situation and I see no point in adding an artificial reg property if I
need multiple nodes by same name. This actually happens quite often with
sound-nodes when I have multiple audio devices in the same system.

But still, there is no need for the unit address here and it should be
removed. I'll do that next time.

Best regard,
Jyri

[1] Documentation/devicetree/bindings/graph.txt
[2] http://devicetree.org/Device_Tree_Usage
