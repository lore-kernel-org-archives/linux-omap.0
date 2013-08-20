From: <thomas.langer@lantiq.com>
Subject: RE: [PATCH v5 1/8] usb: phy: omap-control: Get rid of platform data
Date: Tue, 20 Aug 2013 15:04:44 +0000
Message-ID: <593AEF6C47F46446852B067021A273D6D982D30B@MUCSE039.lantiq.com>
References: <1377010577-19355-1-git-send-email-rogerq@ti.com>
 <1377010577-19355-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1377010577-19355-2-git-send-email-rogerq@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rogerq@ti.com, balbi@ti.com, bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, tony@atomide.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello Roger,

this will not work!

Roger Quadros wrote on=A02013-08-20:

> -	struct omap_control_usb_platform_data *pdata =3D
> -			dev_get_platdata(&pdev->dev);
> +
> +	if (np) {
> +		of_property_read_u32(np, "ti,type", &control_usb->type);

here you are dereferencing control_usb

> +	} else {
> +		/* We only support DT boot */
> +		return -EINVAL;
> +	}
> =

>  	control_usb =3D devm_kzalloc(&pdev->dev, sizeof(*control_usb),
>  		GFP_KERNEL);

and here it is allocated!

Best Regards,
Thomas
