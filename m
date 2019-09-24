From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V2 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date: Tue, 24 Sep 2019 13:56:14 -0500
Message-ID: <CAL_JsqJB54aTWNxh+FsEOBRFEWXBi6WZE3pzqo+LJWM781v-PQ@mail.gmail.com>
References: <20190923134449.22326-1-aford173@gmail.com> <20190923134449.22326-2-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190923134449.22326-2-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, linux-omap <linux-omap@vger.kernel.org>, adam.ford@logicpd.com, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 23, 2019 at 8:45 AM Adam Ford <aford173@gmail.com> wrote:
>
> This patch adds documentation of device tree bindings for the WVGA panel
> Logic PD Type 28 display.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Use YAML instead of TXT for binding

Fails to build with 'make dt_binding_check':

https://patchwork.ozlabs.org/patch/1166057/

Looks like a tab character used perhaps.

Rob
