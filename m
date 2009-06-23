From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Can a phone hook switch follow alsa jack model?
Date: Tue, 23 Jun 2009 15:28:54 +0200
Message-ID: <4A40D896.8010208@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
Cc: linux-input@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I am wondering if it is a good idea to create support for a phone hook 
switch, or a handset pick up switch, like that found on Amstrad E3 
(Delta) videophone, using alsa jack framework.

After my initial attempt to add support for the switch using gpio-keys 
driver, I am no longer sure if it is a good idea to follow the keyboard 
model, that the driver has been designed after, for driving a switch 
that has nothing to do with keyboards and may required a different approach.

OTOH, the switch is closely related to a handset, and handsets can be 
seen as sound devices, can't they? So maybe alsa jack would fit better 
than keyboard?

However, I am not sure if the switch in question matches the alsa jack 
model closely enough. I see the switch usage not as simple as turning 
handset microphone/speaker on or off. It can be used for other purposes 
as well, like accepting a phone call or actually dialing a number that 
has been just typed in. Furthermore, it can be used to turn off a 
speakerphone function, while, in turn, the related handset 
microphone/speaker pair can be turned off not only with this switch, but 
with a handsfree button as well, for example.

All that extra functionality looks like belonging to userspace rather 
then kernel, not like other alsa jack implementations that seem to do 
all the job of switching media paths inside the kernel. That is why I am 
not sure if the jack model is suitable for the purpose.

Thanks,
Janusz

