From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Wed, 12 May 2010 00:40:00 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E08F7B6@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
 <20100421065550.GL4364@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5320@dlee03.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5323@dlee03.ent.ti.com>
 <20100511044156.GA21299@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39233 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab0ELFkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 01:40:04 -0400
In-Reply-To: <20100511044156.GA21299@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dmitry,

2 comments + one question before sending next version...

[...]

> > > > > +static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
> > > > > +{
> > > >
> > > > Why is iti threaded? I fo not see anything that will sleep.
> >
> >
> > It was implemented based on previous comments...
> >
> 
> Would you point me to that comment? Like I said, I do not see anything
> that would possibly sleep in this routine so you don't need to use
> threaded interrupt.

Using now request_irq based on your comments. In same omap_keypad_interrupt disable/clear/enable interrupts will be executed

[...]

> > > > > +	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> > > >
> > > > You forgot to actualy report MSC_SCAN though.
> >
> > Should I remove it? I think I do need it only when KEY_UNKNOWN keys will be
> > remapped, right?
> 
> I'd rather you actually report EV_MSC/MSC_SCAN.

I am reporting now EV_MSC/MSC_SCAN. I am using evtest to read the events, if I press and release a key no code will be reported

  Event: time 946684836.854248, -------------- Report Sync ------------
  Event: time 946684836.854248, -------------- Report Sync ------------

Unless I keep it depressed

  Event: time 946684817.945892, type 1 (Key), code 18 (E), value 2

And after releasing the key some other events will get generated

  Event: time 946684817.967559, type 4 (Misc), code 4 (ScanCode), value 24
  Event: time 946684817.967559, -------------- Report Sync ------------
  Event: time 946684817.967559, type 4 (Misc), code 4 (ScanCode), value 32
  Event: time 946684817.967559, -------------- Report Sync ------------
  Event: time 946684817.967590, type 4 (Misc), code 4 (ScanCode), value 40
  Event: time 946684817.967590, -------------- Report Sync ------------

Am I missing something?

[...]

> 
> >
> > > > > +failed_free_irq:
> > > > > +	free_irq(keypad_data->irq, pdev);
> > > > > +failed_free_base:
> > > > > +	keypad_data->base = NULL;
> > > > > +failed_free_input:
> > > > > +	input_free_device(input_dev);
> > > > > +failed_free_codes:
> > > > > +	kfree(keypad_codes);
> > > > > +failed_free_data:
> > > > > +	kfree(keypad_data);
> > > > > +failed_free_platform:
> > > > > +	kfree(keymap_data);
> > > > > +	kfree(pdata);
> > > > > +	return error;

Using now the following sequence...

	pdata = pdev->dev.platform_data;
		return -EINVAL;

	keymap_data = pdata->keymap_data;
		goto failed_free_pdata;

	keypad_data = kzalloc(sizeof(struct omap_keypad) +
		goto failed_free_keymap;
	
	keypad_data->base = pdata->base;
		goto failed_free_keypad;

	keypad_data->irq = pdata->irq;
		goto failed_free_base;

	input_dev = input_allocate_device();
		goto failed_free_base;

	status = input_register_device(keypad_data->input);
		goto failed_free_input;

	status = request_irq(keypad_data->irq, omap_keypad_interrupt,
		goto failed_unregister_device;

failed_unregister__device:
	input_unregister_device(keypad_data->input);
	input_dev = NULL;
failed_free_input:
	input_free_device(input_dev);
failed_free_base:
	keypad_data->base = NULL;
failed_free_keypad:
	kfree(keypad_data);
failed_free_keymap:
	kfree(keymap_data);
failed_free_pdata:
	kfree(pdata);
	return error;

Best Regards
Abraham
