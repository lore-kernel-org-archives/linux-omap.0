From: Dan Murphy <dmurphy@ti.com>
Subject: Re: Backlight in motorola Droid 4
Date: Wed, 24 Jul 2019 10:22:12 -0500
Message-ID: <ca69f627-96e2-f982-3a29-18b0127ac6e5@ti.com>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20190722205921.GA24787@amd> <b8fbc94f-c087-2c9d-4532-ea423f1626e6@ti.com>
 <20190724124530.GA30211@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724124530.GA30211@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, jacek.anaszewski@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 7/24/19 7:45 AM, Pavel Machek wrote:
<snip>
>
> +
>   static int lm3532_parse_node(struct lm3532_data *priv)
>   {
>   	struct fwnode_handle *child = NULL;
> @@ -536,11 +579,13 @@ static int lm3532_parse_node(struct lm3532_data *priv)
>   		ret = fwnode_property_read_u32(child, "ti,led-mode",
>   					       &led->mode);
>   		if (ret) {
> +		  /* FIXME: should just default to non-als mod */

Looking at the rest of the code.

The DT doc indicated that this was a required child property so this is 
why it

errors out.

Dan

<snip>
