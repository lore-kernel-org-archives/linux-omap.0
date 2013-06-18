From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 2/2] musb: musb: dsps: determine the number of instances
 at runtime
Date: Tue, 18 Jun 2013 10:43:55 +0200
Message-ID: <51C01DCB.3030501@linutronix.de>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de> <1371482014-5244-3-git-send-email-bigeasy@linutronix.de> <20130618083108.GH5461@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130618083108.GH5461-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 06/18/2013 10:31 AM, Felipe Balbi wrote:
> Hi,
Hi Felipe,

>> --- a/drivers/usb/musb/musb_dsps.c +++
>> b/drivers/usb/musb/musb_dsps.c @@ -110,8 +110,6 @@ struct
>> dsps_musb_wrapper { @@ -646,6 +645,23 @@ static int
>> dsps_probe(struct platform_device *pdev) } 
>> platform_set_drvdata(pdev, glue);
>> 
>> +	i = 1; +	do { +		iomem = platform_get_resource(pdev,
>> IORESOURCE_MEM, i);
> 
> IIRC this index starts at zero, no ? Meaning that this should be:
> 
> i = 0 do { iomem = platform_get_resource(pdev, IORESOURCE_MEM, i); 
> if (!iomem) break;
> 
> i++; } while (true);
> 
> glue->instances = i + 1;

No. 3x ioadress i.e. 0, 1, 2 means two instances because we have 0 as
the glue io address and two musb port (1 and 2).

> Also, why are you getting the resource and doing nothing with it ?
> Is it just to figure out the amount of instances ? Isn't there a DT
> helper to

exactly, just to count.

> count how many child nodes a certain node has ?
This isn't exactly a child node, is it? There is of_get_child_count()
but this isn't a child, it is one property.

Sebastian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRwB3LAAoJEHuW6BYqjPXRu1MQALwY/DHJWIKBZm18OdlJizmC
UZMfZCqwtObDtHcbUpMx5jFmF6jblVCY56Vx713oarRYwona65jRuCVp+BmPpvbh
rH7Vfdj7ZK02sSXD49lu/eM+StOoLAEuCdZV5cP2sQCQHzGY50eDVXynjFTmr6wH
nIC/MCPrTLGgH3bWLM1PshmIThbeovp/UupGXU0ABxThL3Dm2EAolBEWjvwAgbZy
CUL3OoUvb6SdJiPkI4ORUvHzyS78JDsvEj1zuCio13m+/FW3uvvQEjIWefS/lAmP
0AyoDf+6VTdAhJVcEev5RJNJpIzFMZDQYjarHO8q5NSwr5WN+h+QOEQjYdQsAfkf
Jv68nnj6mwE1HUv32EnTIu3il0101QU+dU4zDsMykCneMhY2GBXbRqjrfZXiTqKO
WjtJg0HeKhIrG6i5ffLt/4kfPIyXYYJriOqJf2nvlBf7/RqsX4OT5ThIW2BAV7Zx
7qY9CgwDdSjyBq1GpcIGbpBNvzrVGxJfLxNec73EOJmHdu6zCZWLWpujAQIvv3kf
XJWtPXYAVNB7lpSBaxJO6CeSE6YAy5CkxaL8EMeTcqKxwh/ntRw/YLt45MUb8Ao5
J82znl3hByO/9FNPi9KA4A6TDuFtRNNu5lm8o+PdQndTO6heMzJTs8AL/PqH1vRA
q2e6Wxg65ZTs4aUUyVFF
=f5YG
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
