From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 2/5] net: ethernet: cpsw: add optional third memory
 region for CONTROL module
Date: Fri, 23 Aug 2013 16:05:30 +0200
Message-ID: <52176C2A.9000801@gmail.com>
References: <1377247417-27386-1-git-send-email-zonque@gmail.com> <1377247417-27386-3-git-send-email-zonque@gmail.com> <52176BB7.3000405@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <52176BB7.3000405@cogentembedded.com>
Sender: netdev-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, nsekhar@ti.com, davem@davemloft.net, ujhelyi.m@gmail.com, mugunthanvnm@ti.com, vaibhav.bedia@ti.com, d-gerlach@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 23.08.2013 16:03, Sergei Shtylyov wrote:
> On 23-08-2013 12:43, Daniel Mack wrote:

>> +		dev_err(priv->dev, "unable to map control i/o region\n");
> 
>     devm_ioremap_resource() prints out the error messages itself, so you don't 
> have to.

Right. Thanks. Will send a v4.



Best,
Daniel
