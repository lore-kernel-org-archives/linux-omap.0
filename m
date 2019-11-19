From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v7 net-next 10/13] Documentation: networking: add cpsw
 switchdev based driver documentation
Date: Tue, 19 Nov 2019 15:13:50 -0800
Message-ID: <20191119151350.75c72c40@cakuba.netronome.com>
References: <20191119221925.28426-1-grygorii.strashko@ti.com>
        <20191119221925.28426-11-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191119221925.28426-11-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 20 Nov 2019 00:19:22 +0200, Grygorii Strashko wrote:
> diff --git a/Documentation/networking/devlink-params-ti-cpsw-switch.txt b/Documentation/networking/devlink-params-ti-cpsw-switch.txt
> new file mode 100644
> index 000000000000..4037458499f7
> --- /dev/null
> +++ b/Documentation/networking/devlink-params-ti-cpsw-switch.txt
> @@ -0,0 +1,10 @@
> +ale_bypass	[DEVICE, DRIVER-SPECIFIC]
> +		Allows to enable ALE_CONTROL(4).BYPASS mode for debug purposes.
> +		All packets will be sent to the Host port only if enabled.
> +		Type: bool
> +		Configuration mode: runtime
> +
> +switch_mode	[DEVICE, DRIVER-SPECIFIC]
> +		Enable switch mode
> +		Type: bool
> +		Configuration mode: runtime

Ah, you got it here, sorry :)
