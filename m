From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: Re: [PATCH] Input: twl4030-vibra: remove legacy pdata support
Date: Wed, 23 Nov 2016 11:59:31 +0200
Message-ID: <CAKP5S=3QcanPT9J848NFj=YWesKi+Qx+dSXiBvCehV1Jv85Gjw@mail.gmail.com>
References: <1479812398-1122-1-git-send-email-Nicolae_Rosia@mentor.com>
 <d30d4cca-9fcf-befa-0389-1aafaef99ce8@ti.com> <20161123013348.GB21078@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20161123013348.GB21078@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>, Marek Belisko <marek@goldelico.com>, Baruch Siach <baruch@tkos.co.il>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

On Wed, Nov 23, 2016 at 3:33 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> > -static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
>> > -                         struct device_node *node)
>> > +static bool twl4030_vibra_check_coexist(struct device_node *node)
>> >  {
>> > -   if (pdata && pdata->coexist)
>> > -           return true;
>> > -
>> >     node = of_find_node_by_name(node, "codec");
>> >     if (node) {
>> >             of_node_put(node);
>
> Do we need this wrapper anymore?
>
I kept the original logic.
It seems that when there's also a "codec" DT entry, the logic is different.

>> > @@ -194,13 +190,12 @@ static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
>> >
>> >  static int twl4030_vibra_probe(struct platform_device *pdev)
>> >  {
>> > -   struct twl4030_vibra_data *pdata = dev_get_platdata(&pdev->dev);
>
> Should we also remove twl4030_vibra_data definition?
>
Yes, but that is defined in include/linux/i2c/twl.h. Since I've sent
multiple cleanup patches regarding twl, I thought it would be wise to
wait until the next cycle to remove them all to avoid merge conflicts.
I don't know how I should go with this, since I could:
a) make another commit removing the pdata definition
b) include the pdata definition removal in this commit
c) wait until the next cycle

>> >     struct device_node *twl4030_core_node = pdev->dev.parent->of_node;
>> >     struct vibra_info *info;
>> >     int ret;
>> >
>> > -   if (!pdata && !twl4030_core_node) {
>> > -           dev_dbg(&pdev->dev, "platform_data not available\n");
>> > +   if (!twl4030_core_node) {
>> > +           dev_err(&pdev->dev, "no DT info\n\n");
>
> Why double newline?
This is a typo. Should I send v2 or you can modify it while applying?

Thanks,
Nicolae
